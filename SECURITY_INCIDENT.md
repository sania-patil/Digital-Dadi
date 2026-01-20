# Security Incident - API Key Exposure

## Issue
Google API Key was publicly leaked in the repository: `AIzaSyCqQSfLfrFYF2Vi_sir7kPx41Hj3AgKhQs`

## Remediation Steps Completed ✅

### 1. **Revoke the Leaked Key**
- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Navigate to **APIs & Services** → **Credentials**
- Find and delete the exposed API key: `AIzaSyCqQSfLfrFYF2Vi_sir7kPx41Hj3AgKhQs`
- Generate a **new API key** for your project

### 2. **Update Configuration**
- ✅ Replaced the exposed key with placeholder in `android/app/google-services.json`
- ✅ Added sensitive files to `.gitignore`:
  - `google-services.json`
  - `*.key`
  - `*.keystore`
  - `*.jks`
  - `.env`
  - `.env.local`

### 3. **Create Configuration Template**
- ✅ Created `android/app/google-services.json.example` as a template for developers

### 4. **Git History Cleanup**
Run these commands to remove the key from git history:

```bash
# Remove the file from git history
git rm --cached android/app/google-services.json

# Rewrite history (be careful with this!)
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch android/app/google-services.json' --prune-empty -- --all

# Force push (only if you own the repo)
git push origin --force --all
```

### 5. **Security Audit**
- Review git logs for other exposed secrets
- Check if key was used to access sensitive resources
- Monitor Google Cloud Console for unauthorized API usage

### 6. **Going Forward**
- Never commit `google-services.json` directly
- Use `.gitignore` to exclude sensitive files
- Store production keys in secure vaults (e.g., GitHub Secrets, Firebase Console)
- Rotate keys regularly
- Use restricted API keys with specific permissions

## Files Modified
- `android/app/google-services.json` - Key replaced with placeholder
- `.gitignore` - Added sensitive file patterns
- `android/app/google-services.json.example` - Created template for setup

## Next Steps
1. Contact Google Cloud support to audit API usage for this key
2. Generate a new API key in Google Cloud Console
3. Update `android/app/google-services.json` with the new key
4. Re-download from Firebase Console to ensure all credentials are current
5. Force push to remove history (coordinate with team)
