--- @since 26.5.6

local PY = [==[
import sys, zipfile, re, html, os

path = sys.argv[1]
width = int(sys.argv[2])
height = int(sys.argv[3])

def truncate_lines(lines, height, width):
    result = []
    for line in lines:
        if len(line) > width:
            line = line[:width]
        result.append(line)
        if len(result) >= height - 2:
            result.append("... (truncated)")
            break
    return result

def extract_xml_text(xml):
    xml = re.sub(r"<w:tab[^>]*/>", "\t", xml)
    xml = re.sub(r"</w:p>|<w:br/>", "\n", xml)
    texts = re.findall(r">([^<]{1,})<", xml)
    out = []
    for t in texts:
        t = html.unescape(t).strip()
        if t:
            out.append(t)
    return out

def preview_docx(z):
    try:
        xml = z.read("word/document.xml").decode("utf-8", "ignore")
    except KeyError:
        return ["[Khong tim thay word/document.xml]"]
    paragraphs = re.split(r"</w:p>", xml)
    lines = []
    for p in paragraphs:
        ts = re.findall(r"<w:t[^>]*>([^<]*)</w:t>", p, re.S)
        line = html.unescape("".join(ts)).strip()
        if line:
            lines.append(line)
    return lines or ["[Van ban trong]"]

def preview_xlsx(z):
    try:
        ss_xml = z.read("xl/sharedStrings.xml").decode("utf-8", "ignore")
        shared = [html.unescape(s) for s in re.findall(r"<t[^>]*>([^<]*)</t>", ss_xml, re.S)]
    except KeyError:
        shared = []
    lines = []
    try:
        sheet = sorted([n for n in z.namelist() if re.match(r"xl/worksheets/sheet\d+\.xml", n)])[0]
        xml = z.read(sheet).decode("utf-8", "ignore")
        rows = re.findall(r"<row[^>]*r=\"(\d+)\"[^>]*>(.*?)</row>", xml, re.S)
        for row_num, row_xml in rows:
            cells = re.findall(r'<c r="([A-Z]+)(?:\d+)"([^>]*)>(.*?)</c>|<c r="([A-Z]+)(?:\d+)"([^>]*)/>', row_xml, re.S)
            row_vals = []
            for m in cells:
                if m[0]:
                    col, attrs, inner = m[0], m[1], m[2]
                else:
                    col, attrs, inner = m[3], m[4], ""
                typ = re.search(r't="(\w+)"', attrs)
                v = re.search(r"<v>([^<]*)</v>", inner)
                val = v.group(1) if v else ""
                if typ and typ.group(1) == "s" and val.isdigit() and int(val) < len(shared):
                    val = shared[int(val)]
                row_vals.append((col, val))
            if row_vals:
                cols = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                full = []
                for c in cols:
                    found = next((v for cc, v in row_vals if cc == c), "")
                    full.append(found)
                while full and full[-1] == "":
                    full.pop()
                if any(full):
                    lines.append(" | ".join(v[:14] for v in full))
    except (KeyError, IndexError):
        lines = shared[:height-2]
    return lines or ["[Trong hoac khong doc duoc]"]

def preview_pptx(z):
    slides = sorted([n for n in z.namelist() if re.match(r"ppt/slides/slide\d+\.xml", n)],
                    key=lambda n: int(re.search(r"(\d+)", n).group(1)))
    lines = []
    for s in slides:
        xml = z.read(s).decode("utf-8", "ignore")
        texts = re.findall(r"<a:t[^>]*>([^<]*)</a:t>", xml, re.S)
        cleaned = [html.unescape(t).strip() for t in texts if t.strip()]
        if cleaned:
            lines.append(f"--- {os.path.basename(s)} ---")
            lines.extend(cleaned)
    return lines

def preview_odt(z):
    try:
        xml = z.read("content.xml").decode("utf-8", "ignore")
    except KeyError:
        return ["[Khong tim thay content.xml]"]
    xml = re.sub(r"<text:line-break[^>]*/>", "\n", xml)
    xml = re.sub(r"</text:p[^>]*>|<text:p[^>]*/>", "\n", xml)
    texts = re.findall(r">([^<]{1,})<", xml)
    lines = []
    for t in texts:
        t = html.unescape(t).strip()
        if t:
            lines.append(t)
    return lines

try:
    with zipfile.ZipFile(path) as z:
        ext = path.lower().rsplit(".", 1)[-1] if "." in path else ""
        if ext == "docx":
            lines = preview_docx(z)
        elif ext == "xlsx":
            lines = preview_xlsx(z)
        elif ext == "pptx":
            lines = preview_pptx(z)
        elif ext in ("odt", "ods", "odp"):
            lines = preview_odt(z)
        else:
            lines = ["[Dinh dang khong ho tro]"]
except zipfile.BadZipFile:
    lines = ["[Khong phai file Office hop le]"]
except Exception as e:
    lines = [f"[Loi: {e}]"]

lines = truncate_lines(lines, height, width)
sys.stdout.write("\n".join(lines))
]==]

local M = {}

function M:peek(job)
	local url = tostring(job.file.url)
	local w = math.max(1, job.area.w)
	local h = math.max(1, job.area.h)

	local output, err = Command("python3")
		:arg({ "-c", PY, url, tostring(w), tostring(h) })
		:output()
	if not output then
		ya.preview_widget(job, ui.Text("Failed to preview: " .. tostring(err)):area(job.area))
		return
	end
	local text = output.stdout:gsub("\n+$", "")
	if text == "" then
		text = "[Khong co noi dung preview]"
	end
	ya.preview_widget(job, ui.Text(text):area(job.area):wrap(ui.Wrap.NO))
end

function M:seek(job)
	local h = cx.active.current.hovered
	if not h or h.url ~= job.file.url then
		return
	end
	local step = math.floor(job.units * job.area.h / 2)
	step = step == 0 and ya.clamp(-1, job.units, 1) or step
	ya.emit("peek", {
		math.max(0, cx.active.preview.skip + step),
		only_if = job.file.url,
	})
end

return M