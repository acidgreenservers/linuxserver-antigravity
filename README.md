# linuxserver-antigravity
*A multi-arch Docker container providing dual IDE development environment*

![Build](https://github.com/acidgreenservers/linuxserver-antigravity/actions/workflows/build.yml/badge.svg)
![License](https://img.shields.io/github/license/acidgreenservers/linuxserver-antigravity)

## Overview

linuxserver-antigravity is a multi-architecture Docker container built on [linuxserver/vscodium](https://github.com/linuxserver/docker-vscodium) that provides a complete web-based development environment featuring **two integrated IDEs**:

- **VSCodium**: Full-featured, open-source code editor
- **Antigravity IDE**: Google's advanced development environment

Instantly deployable via webVNC, with right-click integration, persistent data management, and zero-maintenance automatic updates.

## 🎯 Features

### Core Functionality
- **Dual IDE Environment**: VSCodium + Antigravity IDE accessible via webVNC interface
- **Seamless Integration**: Right-click context menu: "Open in Antigravity"
- **Desktop Environment**: Full XFCE desktop with KasmVNC for remote access
- **Multi-Platform Support**: Built for linux/amd64 and linux/arm64 architectures

### Development Experience
- **Zero Configuration**: Pull → Run → Develop (persistent config via volumes)
- **Workspaces**: Mount host directories as `/workspace` for easy file access
- **Persistent Data**: IDE configurations and extensions saved to `/config`

### Automation & Maintenance
- **Auto-Updates**: Diun webhook monitoring for base image and IDE updates
- **Weekly Checks**: Scheduled CI for new Antigravity releases
- **Security**: SHA256 validation of all downloaded artifacts
- **linuxserver Compatible**: Same update workflow as official images

## 🚀 Quick Start

### Deploy with Docker Compose
```yaml
services:
  antigravity:
    image: ghcr.io/acidgreenservers/linuxserver-antigravity:latest
    container_name: antigravity
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Los_Angeles
    volumes:
      - ./config:/config
      - ./workspace:/workspace
    ports:
      - 3000:3000
    restart: unless-stopped
```

### Access & Usage
1. Open `http://localhost:3000` in your browser
2. VNC password: `vncpassword` (default) - set `VNC_PASSWD` env var for custom
3. Both IDEs available from desktop menu
4. Right-click folders → "Open in Antigravity"

### Updates
```bash
docker-compose pull && docker-compose up -d
```

## 🏗️ Architecture

### Container Structure
```
linuxserver/vscodium:latest (base)
├── Antigravity IDE (version 1.11.3)
│   └── Installed from Google CDN distribution
├── XFCE Desktop Environment
├── s6-overlay Process Manager
├── Desktop Integration
│   ├── .desktop files for menu entries
│   ├── Right-click context handlers
│   └── Service definitions for startup
└── Persistent Storage
    ├── /config → IDE data and configurations
    └── /workspace → Host-mapped development files
```

### CI/CD Pipeline
- **GitHub Actions**: Multi-arch builds with QEMU emulation
- **GHCR**: Container registry hosting with semantic versioning
- **Diun**: Automated update monitoring for base image changes
- **Automated Releases**: Weekly scans for new Antigravity versions

## 📋 Build Requirements

### GitHub Setup
1. **Create Repository**: `linuxserver-antigravity`
2. **Push Code**:
   ```bash
   git remote add origin https://github.com/acidgreenservers/linuxserver-antigravity.git
   git push -u origin main
   ```

3. **Configure Settings**:
   - Actions → General → Allow all actions
   - Packages → Visibility → Public

4. **Environment Secrets**:
   ```
   DOCKER_USER    → your_github_username
   DOCKER_TOKEN   → github_personal_access_token (packages scope)
   DIUN_GH_TOKEN  → github_personal_access_token (repo scope)
   ```

### Workflow Update
Replace `acidgreenservers` in `.github/workflows/build.yml` with your GitHub username before first build.

## 🧪 Testing & Verification

After deployment, verify the container works by testing:

- **Multi-architecture support**: Confirm builds for both `linux/amd64` and `linux/arm64`
- **Distribution integrity**: Verify Antigravity installation succeeds from .tar.gz download
- **Performance**: Check container startup time (target ≤30 seconds)
- **IDE functionality**: Both editors appear in desktop menu and launch correctly
- **Desktop integration**: Right-click context menu opens folders in Antigravity
- **Data persistence**: IDE settings survive container recreations
- **Network access**: WebVNC interface accessible at http://localhost:3000

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-improvement`
3. Make changes following standard engineering practices
4. Commit with descriptive messages
5. Open a Pull Request

### Standards
- **Code Quality**: Follow established patterns in the codebase
- **Testing**: Verify functionality on both amd64 and arm64 platforms
- **Documentation**: Update README for any user-facing changes

### Testing Locally
```bash
# Build the container locally
docker build -t linuxserver-antigravity:local .

# Run for testing
docker run -d -p 3000:3000 --name test-antigravity linuxserver-antigravity:local
```

## 📖 Architecture

The container is built using standard linuxserver patterns and practices for consistency and maintainability.

## 🔧 Troubleshooting

### Common Issues
- **Container won't start**: Check `docker logs antigravity` for permission or network issues
- **IDE not found**: Verify Antigravity download succeeded during build
- **Right-click not working**: Check desktop integration files in `/defaults/`
- **Updates not applying**: Ensure Diun webhook or manual pulldown

### Logs
```bash
# Container logs
docker logs antigravity

# IDE-specific logs
docker exec antigravity cat /config/antigravity-data/logs/*.log
```

## 📋 Frequently Asked Questions

**Q: Can I use this locally without GitHub CI?**  
A: Yes, build locally with `docker build` but you'll miss auto-update benefits.

**Q: How do I backup my IDE configurations?**  
A: Mount `/config` volume contains all IDE data and settings.

**Q: What if Antigravity updates and breaks compatibility?**  
A: SHA256 validation prevents automatic broken deployments - manual intervention required.

**Q: Can I customize the IDE startup options?**  
A: Modify service scripts in `root/etc/s6-overlay/s6-rc.d/svc-antigravity/run`

**Q: Is FUSE required for Antigravity?**  
A: No, tar.gz extraction replaces previous AppImage approach, eliminating FUSE dependency.

## 🏆 Acknowledgments

- **linuxserver.io**: For the exceptional vscodium base image and automation patterns
- **Google**: For Antigravity IDE and CDN distribution infrastructure

## 📄 License

MIT License - same as linuxserver build automation scripts.

