# 🚀 Quick Start Guide

Get linuxserver-antigravity running in under 5 minutes!

## Prerequisites
- Docker installed and running
- GitHub account with the container built (see main README)

## 1. Clone or Download

```bash
git clone https://github.com/YOUR_USER/linuxserver-antigravity.git
cd linuxserver-antigravity
```

## 2. Configure Image Name

Edit `docker-compose.yml` and replace `YOUR_USER` with your GitHub username:

```yaml
image: ghcr.io/YOUR_USER/linuxserver-antigravity:latest
```

## 3. Launch Container

```bash
docker-compose up -d
```

That's it! Your development environment is now running.

## 4. Access IDEs

- Open `http://localhost:3000` in your browser
- Password: `vncpassword`
- Double-click "VSCodium" or "Antigravity" on the desktop
- Right-click folders → "Open in Antigravity"

## Files & Directories

After startup, you'll have:
- `./config/` - IDE settings and extensions (persistent)
- `./workspace/` - Your development files (mount your projects here)

## Common Commands

```bash
# Stop container
docker-compose down

# Update to latest version
docker-compose pull && docker-compose up -d

# View logs
docker-compose logs -f antigravity

# Restart container
docker-compose restart
```

## Need Help?

- Check `docker-compose logs` for errors
- Verify the image exists: `docker pull ghcr.io/YOUR_USER/linuxserver-antigravity:latest`
- Test access: `curl http://localhost:3000`

## Troubleshooting

**Can't access http://localhost:3000?**
- Wait 30 seconds after `docker-compose up`
- Check if port 3000 is available: `netstat -tlnp | grep 3000`

**VNC connection refused?**
- Container may still starting up
- Check logs: `docker-compose logs antigravity`

**Image pull fails?**
- Ensure GitHub Actions built successfully
- Verify `YOUR_USER` is correct in compose file
- Check package visibility in GitHub settings

Happy coding! 🎉
