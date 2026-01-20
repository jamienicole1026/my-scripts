# Automation Scripts

Scripts for recurring tasks, scheduled jobs, and workflow automation.

## Script Ideas

### System Maintenance
- Backup automation
- Cleanup temporary files
- Update software
- System health checks

### Productivity
- Daily standup reminders
- Time tracking helpers
- Task management utilities
- Calendar integration

### Scheduled Tasks
- Nightly backups
- Weekly reports
- Monthly archiving
- Periodic cleanups

## Tips

- Use cron or launchd for scheduling on macOS
- Include logging for scheduled scripts
- Add error notifications
- Keep scripts idempotent (safe to run multiple times)

## Example Cron Entry
```bash
# Run backup every day at 2 AM
0 2 * * * /Users/jamiealbright/dev/scripts/automation/backup.sh
```
