# 0x10. HTTPS SSL

## Description
This project focuses on implementing HTTPS SSL and understanding web security fundamentals. You'll learn about SSL termination, DNS configuration, and secure web traffic handling using HAProxy as a load balancer.

## Learning Objectives
By the end of this project, you should be able to explain:
- What is HTTPS SSL and its 2 main roles
- What is the purpose of encrypting traffic
- What SSL termination means
- How to configure DNS records for subdomains
- How to implement SSL termination with HAProxy

## Project Requirements
- **Allowed editors:** `vi`, `vim`, `emacs`
- **Environment:** Ubuntu 16.04 LTS
- All files should end with a new line
- All Bash script files must be executable
- Scripts must pass `Shellcheck` (version 0.3.7) without errors
- First line of Bash scripts: `#!/usr/bin/env bash`
- Second line: Comment explaining what the script does

## Tasks

### 0. World Wide Web
**Mandatory**

Configure your domain zone so that the subdomain `www` points to your load-balancer IP (`lb-01`). Create a Bash script that displays information about subdomains.

#### Requirements:
- Add subdomain `www` pointing to your `lb-01` IP
- Add subdomain `lb-01` pointing to your `lb-01` IP  
- Add subdomain `web-01` pointing to your `web-01` IP
- Add subdomain `web-02` pointing to your `web-02` IP

#### Script Specifications:
- **File:** `0-world_wide_web`
- **Arguments:**
  1. `domain` (mandatory): Domain name to audit
  2. `subdomain` (optional): Specific subdomain to audit
- **Output format:** `The subdomain [SUB_DOMAIN] is a [RECORD_TYPE] record and points to [DESTINATION]`

#### Functionality:
- When only `domain` is provided: Display info for `www`, `lb-01`, `web-01`, `web-02` (in this order)
- When both `domain` and `subdomain` are provided: Display info for specified subdomain only
- Must use `awk` and at least one Bash function
- Ignore shellcheck case `SC2086`

#### Usage Examples:

```bash
# Display all subdomains
./0-world_wide_web holberton.online

# Output:
# The subdomain www is a A record and points to 54.210.47.110
# The subdomain lb-01 is a A record and points to 54.210.47.110
# The subdomain web-01 is a A record and points to 34.198.248.145
# The subdomain web-02 is a A record and points to 54.89.38.100

# Display specific subdomain
./0-world_wide_web holberton.online web-02

# Output:
# The subdomain web-02 is a A record and points to 54.89.38.100
```

#### DNS Record Types Explained:
- **A Record:** Maps domain name to IPv4 address
- **AAAA Record:** Maps domain name to IPv6 address  
- **CNAME Record:** Maps domain name to another domain name
- **MX Record:** Specifies mail exchange servers

#### Infrastructure Overview:
```
Internet → www.domain.com → Load Balancer (lb-01) → Web Servers (web-01, web-02)
```

- **Load Balancer (lb-01):** Distributes incoming requests
- **Web Servers (web-01, web-02):** Handle actual web content
- **DNS Records:** Route traffic to appropriate servers

## File Structure
```
0x10-https_ssl/
├── README.md
├── 0-world_wide_web
└── [other task files...]
```

## Tools Used
- **dig:** DNS lookup utility
- **awk:** Text processing tool
- **HAProxy:** Load balancer with SSL termination capabilities
- **Bash:** Scripting and automation

## Testing Your Setup

### 1. Test DNS Resolution:
```bash
# Test individual subdomains
dig www.your-domain.com
dig lb-01.your-domain.com
dig web-01.your-domain.com
dig web-02.your-domain.com
```

### 2. Verify Script Functionality:
```bash
# Make script executable
chmod +x 0-world_wide_web

# Test with domain only
./0-world_wide_web your-domain.com

# Test with specific subdomain
./0-world_wide_web your-domain.com www
```

### 3. Validate Output Format:
Ensure output matches exactly:
```
The subdomain [SUB_DOMAIN] is a [RECORD_TYPE] record and points to [DESTINATION]
```

## Security Considerations
- **DNS Security:** Ensure your DNS records are properly configured
- **Load Balancing:** Distribute traffic evenly across backend servers
- **SSL Preparation:** This task prepares infrastructure for SSL implementation

## Troubleshooting

### Common Issues:
1. **DNS Propagation:** Changes may take up to 48 hours to propagate globally
2. **Record Type:** Ensure you're using A records for IPv4 addresses
3. **Script Permissions:** Make sure script has execute permissions (`chmod +x`)
4. **Shellcheck Errors:** Run `shellcheck 0-world_wide_web` to identify issues

### Debug Commands:
```bash
# Check DNS propagation
dig +trace www.your-domain.com

# Verify script syntax
bash -n 0-world_wide_web

# Run shellcheck
shellcheck 0-world_wide_web
```

## Next Steps
After completing this task, you'll proceed to:
- SSL certificate generation and installation
- HAProxy SSL termination configuration
- HTTPS traffic testing and validation

## Resources
- [What is HTTPS?](https://www.cloudflare.com/learning/ssl/what-is-https/)
- [DNS Record Types](https://www.cloudflare.com/learning/dns/dns-records/)
- [HAProxy Documentation](http://www.haproxy.org/download/1.8/doc/configuration.txt)

## Author
**ALX System Engineering & DevOps Program**

---
**Note:** Replace `your-domain.com` with your actual domain name and update IP addresses according to your server configuration.