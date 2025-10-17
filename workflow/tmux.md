# ref
https://superuser.com/questions/343572/how-do-i-reorder-tmux-windows
https://blog.gtwang.org/linux/linux-tmux-terminal-multiplexer-tutorial/

# issue
The error message "xsel: Can't open display: (null) : Connection refused" when using `xsel` within an `ssh` and `tmux` session indicates a problem with X11 forwarding. `xsel` relies on an X server to interact with the clipboard, and if X11 forwarding is not correctly configured or the `DISPLAY` environment variable is not properly set within the `tmux` session, `xsel` will be unable to connect to the display.

Here's how to address this issue:

- **Enable X11 Forwarding in SSH:**
    
    - **Client-side:** Ensure `ForwardX11 yes` is in your `~/.ssh/config` file, or use `ssh -X` (or `ssh -Y` for trusted forwarding) when connecting to the remote server.
    - **Server-side:** Verify that `X11Forwarding yes` is present and uncommented in `/etc/ssh/sshd_config` on the remote server, and restart the `sshd` service if changes were made.
    
- Verify `DISPLAY` variable:
    
    - After connecting via `ssh -X` (or `-Y`), check the `DISPLAY` environment variable within your `tmux` session using `echo $DISPLAY`. It should typically be set to something like `localhost:10.0`. If it's `(null)` or incorrect, this points to a forwarding issue.
    
- Handle `tmux` and `DISPLAY` variable:
    
    - When resuming a `tmux` session, the `DISPLAY` variable might not be correctly updated from the new SSH connection. To refresh it within a `tmux` session, use:

- Code

```
        eval $(tmux showenv -s | grep -E '^(SSH|DISPLAY)')
```

- This command re-evaluates the `SSH_AUTH_SOCK` and `DISPLAY` environment variables within your current shell to match the active SSH connection.

- **Local X Server (if needed):**
    - If you are connecting from a Windows client, you need to run an X server application like Xming on your local machine for X11 forwarding to function. macOS users typically use XQuartz for similar functionality.

By ensuring X11 forwarding is enabled at both the client and server levels, and by correctly managing the `DISPLAY` environment variable within your `tmux` session, you can resolve the "Can't open display" error and enable `xsel` functionality.