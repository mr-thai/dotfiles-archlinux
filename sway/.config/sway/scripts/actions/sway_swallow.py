#!/usr/bin/env python3
import i3ipc
import subprocess

sway = i3ipc.Connection()
swallowed_windows = {}

def get_child_pids(ppid):
    try:
        output = subprocess.check_output(['pgrep', '-P', str(ppid)]).decode('utf-8')
        return [int(pid) for pid in output.split()]
    except subprocess.CalledProcessError:
        return []

def get_all_descendants(pid):
    descendants = set()
    children = get_child_pids(pid)
    for child in children:
        descendants.add(child)
        descendants.update(get_all_descendants(child))
    return descendants

def on_window_new(i3, e):
    new_win = e.container
    if not new_win.pid:
        return
    
    new_pid = new_win.pid
    
    terminals = [w for w in i3.get_tree().leaves() if w.app_id in ['foot', 'Alacritty', 'kitty']]
    
    for term in terminals:
        if term.id == new_win.id:
            continue
        if term.pid:
            descendants = get_all_descendants(term.pid)
            if new_pid in descendants:
                swallowed_windows[new_win.id] = term.id
                term.command('move to scratchpad')
                break

def on_window_close(i3, e):
    closed_win_id = e.container.id
    if closed_win_id in swallowed_windows:
        term_id = swallowed_windows.pop(closed_win_id)
        i3.command(f'[con_id="{term_id}"] scratchpad show')
        i3.command(f'[con_id="{term_id}"] floating disable')
        i3.command(f'[con_id="{term_id}"] focus')

sway.on('window::new', on_window_new)
sway.on('window::close', on_window_close)

try:
    sway.main()
except Exception as e:
    pass
