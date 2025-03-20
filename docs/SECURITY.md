# Security Policy

## Supported Versions

The following versions of the Localization Comparison Tool are currently being supported with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

I take the security of the Localization Comparison Tool seriously. If you believe you've found a security vulnerability, please follow these steps:

1. **Do Not** disclose the vulnerability publicly
2. **Email** your findings to [alpyalay@gmail.com](mailto:alpyalay@gmail.com)
3. Or reach out via GitHub by creating a private security advisory in the repository

### What to Include in Your Report

- A description of the vulnerability
- Steps to reproduce the issue
- Potential impact of the vulnerability
- Any potential solutions you might recommend

### What to Expect

Once you've submitted a vulnerability report:

- You'll receive acknowledgement of your report within 48 hours
- I'll investigate and determine the impact and severity of the issue
- I aim to provide regular updates about my progress
- Once the issue is resolved, I'll credit you in the security advisory (unless you prefer to remain anonymous)

## Security Updates and Vulnerability Management

### Recent Security Updates

- **May 2024**: Updated GitPython dependency to version 3.1.41+ to address multiple security vulnerabilities:
  - CVE-2024-22190 and CVE-2023-41040: Fixed in version 3.1.41
  - CVE-2023-40267: Vulnerability in versions before 3.1.32 related to insecure options in clone commands
  - CVE-2022-46749: Remote Code Execution vulnerability due to improper input validation in the clone command

- **June 2024**: Security advisory for colorama package:
  - A sophisticated cyberattack distributed compromised versions of colorama
  - Pinned to verified secure version 0.4.6
  - Users should verify package integrity and check for official advisories

- **June 2024**: Updated PyYAML to address security vulnerabilities:
  - Versions prior to 5.4.1 contained arbitrary code execution vulnerabilities
  - Updated to require version 6.0.1+ which has no reported direct vulnerabilities
  - CVE-2020-14343: Fixed in version 5.4.1 (arbitrary code execution via the load() function)
  - CVE-2020-1747: Fixed in version 5.3.1 (code execution vulnerability)
  
### Dependency Vulnerability Management

The project regularly audits dependencies for security vulnerabilities using:
- GitHub's Dependabot alerts
- Manual verification of dependency versions
- Regular updates to address known CVEs
- Package integrity verification for critical dependencies

Users and contributors are encouraged to keep their dependencies updated to the latest secure versions.

### Verifying Package Integrity

To verify the integrity of installed packages:

1. Use pip to install from trusted sources:
   ```
   pip install --require-hashes -r requirements.txt
   ```

2. Check installed package versions:
   ```
   pip list
   ```

3. For colorama specifically, verify the package was installed from PyPI and not a malicious mirror:
   ```
   pip show colorama
   ```

4. Consider using virtual environments for isolation.

## Security Best Practices for Users

When using the Localization Comparison Tool:

- Always download releases from the official [GitHub repository](https://github.com/KhazP/LocalizerAppMain/releases)
- Verify file checksums when available
- Keep your installation updated to the latest version
- Be cautious with localization files from untrusted sources
- Use the pinned dependency versions in requirements.txt
- Consider using `pip-audit` to scan for vulnerable dependencies

## Development Security Practices

For developers contributing to the project:

- All code is reviewed before merging
- Dependencies are regularly audited
- I follow secure coding practices
- I use GitHub's security features to scan for vulnerabilities

## Contact

- **Maintainer:** Alp Yalay
- **GitHub:** [@KhazP](https://github.com/KhazP)

---

Last updated: June 2024
