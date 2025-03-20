"""
Script to verify the security of installed packages.
Run with: python scripts/verify_packages.py
"""
import importlib.metadata
import pkg_resources
import sys
import os
import hashlib
import subprocess
import platform

# Define secure versions
SECURE_VERSIONS = {
    "colorama": "0.4.6",
    "PyYAML": "6.0.1",
    "GitPython": "3.1.41",
}

def check_version(package_name, secure_version):
    """Check if the installed version meets security requirements."""
    try:
        installed_version = pkg_resources.get_distribution(package_name).version
        meets_requirement = pkg_resources.parse_version(installed_version) >= pkg_resources.parse_version(secure_version)
        return {
            "name": package_name,
            "installed": installed_version,
            "required": secure_version,
            "secure": meets_requirement
        }
    except pkg_resources.DistributionNotFound:
        return {
            "name": package_name,
            "installed": "Not installed",
            "required": secure_version,
            "secure": False
        }
    except Exception as e:
        return {
            "name": package_name,
            "installed": "Error",
            "required": secure_version,
            "secure": False,
            "error": str(e)
        }

def get_colorama_path():
    """Get the path to the installed colorama package."""
    try:
        import colorama
        return os.path.dirname(colorama.__file__)
    except ImportError:
        return "Not installed"
    except Exception as e:
        return f"Error: {str(e)}"

def print_results(results):
    """Print verification results."""
    print("\n=== PACKAGE SECURITY VERIFICATION ===")
    
    all_secure = True
    for result in results:
        status = "✅ SECURE" if result["secure"] else "❌ VULNERABLE"
        all_secure = all_secure and result["secure"]
        
        print(f"\n{result['name']}:")
        print(f"  Installed: {result['installed']}")
        print(f"  Required:  {result['required']}")
        print(f"  Status:    {status}")
        
        if not result["secure"] and "error" in result:
            print(f"  Error:     {result['error']}")
    
    print("\n=== ADDITIONAL INFORMATION ===")
    
    # Check colorama installation path
    colorama_path = get_colorama_path()
    print(f"\nColorama installation path: {colorama_path}")
    
    # Get pip version
    try:
        pip_version = subprocess.check_output([sys.executable, "-m", "pip", "--version"], text=True).strip()
        print(f"Pip version: {pip_version}")
    except Exception as e:
        print(f"Could not determine pip version: {str(e)}")
    
    # Final summary
    print("\n=== SUMMARY ===")
    if all_secure:
        print("✅ All checked packages meet security requirements.")
    else:
        print("❌ One or more packages do not meet security requirements.")
        print("\nRecommended action:")
        print("  pip install --upgrade -r requirements.txt")
    
    print("\nFor more information, see docs/SECURITY.md")

def main():
    """Main function to verify package security."""
    results = []
    
    for package, version in SECURE_VERSIONS.items():
        results.append(check_version(package, version))
    
    print_results(results)
    
    # Return success status for scripting
    return all(result["secure"] for result in results)

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
