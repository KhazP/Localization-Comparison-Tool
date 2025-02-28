from setuptools import setup, find_packages

setup(
    name="Localization Comparison Tool",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "flet>=0.7.0",  # Main GUI framework
        "pyyaml",       # For YAML file parsing
        "xmltodict",    # For XML file parsing
    ],
    extras_require={
        "full": [
            "darkdetect",  # For system theme detection
            "google-cloud-translate>=2.0.0",  # For translation features
        ]
    },
    python_requires=">=3.8",
    author="Alp Yalay",
    description="An Open-Source Localization File Comparison Tool",
    long_description=open("docs/README.md").read(),
    long_description_content_type="text/markdown",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
    ],
    entry_points={
        "console_scripts": [
            "localizer=GUI.flet_gui:main",
        ],
    }
)
