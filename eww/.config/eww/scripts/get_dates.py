#!/usr/bin/env python3
import datetime
import subprocess
import json
import sys

def get_dates():
    try:
        # Lấy ngày dương lịch
        now = datetime.datetime.now()
        weekdays = ["Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy", "Chủ Nhật"]
        duong_lich = f"{weekdays[now.weekday()]}, {now.strftime('%d/%m/%Y')}"

        # Lấy ngày âm lịch thông qua thư viện lunar-vn
        # Lệnh: lunar-vn today --json
        result = subprocess.run(['lunar-vn', 'today', '--json'], capture_output=True, text=True)
        if result.returncode == 0:
            data = json.loads(result.stdout)
            day = data.get('lunar', {}).get('day', '')
            month = data.get('lunar', {}).get('month', '')
            year_name = data.get('lunar', {}).get('year_name', '')
            am_lich = f"Ngày {day} Tháng {month} Năm {year_name}"
        else:
            am_lich = "Chưa cài lunar-vn (pip install lunar-vn)"
        
        # In ra định dạng cho Eww Tooltip
        print(f"🌞 {duong_lich}\n🌙 {am_lich}")

    except Exception as e:
        print(f"Lỗi: {e}")

if __name__ == "__main__":
    get_dates()
