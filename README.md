# My Scripts

A collection of useful scripts for automating tasks and workflows.

## 📁 Structure

### [web/](web/)
Scripts for web scraping, downloading, and web-related automation.
- **getpdfs.sh** - Download all PDF files from a webpage

### [files/](files/)
File manipulation, conversion, and organization scripts.
- File format conversion
- Bulk renaming and organizing
- Image processing

### [automation/](automation/)
Recurring tasks, scheduled jobs, and workflow automation.
- Backup scripts
- System maintenance
- Productivity helpers

### [practice/](practice/)
Experimental code and learning projects.
- No pressure sandbox for testing ideas
- Code experiments
- Tutorial follow-alongs

### [templates/](templates/)
Starter templates and boilerplate for common script types.
- **bash-script-template.sh** - Full-featured bash script starter

## 🚀 Quick Start

Clone this repo to access all your scripts:
```bash
git clone https://github.com/jamienicole1026/my-scripts.git
cd my-scripts
chmod +x **/*.sh  # Make all scripts executable
```

## 💡 Usage Examples

### Download PDFs from a webpage
```bash
./web/getpdfs.sh https://example.com/papers.html
```

### Start a new script from template
```bash
cp templates/bash-script-template.sh web/my-new-script.sh
# Edit my-new-script.sh with your logic
```

## ➕ Adding New Scripts

1. Choose the right folder for your script
2. Add inline documentation (see templates for examples)
3. Make it executable: `chmod +x your-script.sh`
4. Test it!
5. Commit and push:
```bash
git add .
git commit -m "Add [description]"
git push
```

## 📝 Documentation Standards

Each script should include:
- What it does (brief description)
- How to use it (examples)
- Any requirements or dependencies
- Author and date (optional)

See `templates/bash-script-template.sh` for a full example.

## 🤝 Contributing

This is a personal collection, but feel free to use any scripts you find useful!

## 🔒 Note on Sensitive Scripts

This is a **public** repository. For practice-related or sensitive scripts, use the private `practice-tools` repo instead.
