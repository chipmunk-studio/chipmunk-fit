import subprocess
import os

def build_catalog_app():
    catalog_path = os.path.join(os.path.dirname(__file__), "catalog")
    
    print(f"Navigating to {catalog_path}")
    os.chdir(catalog_path)
    
    print("Running flutter pub get...")
    subprocess.run(["flutter", "pub", "get"], check=True)
    
    print("Building catalog app (Android APK)...")
    subprocess.run(["flutter", "build", "apk"], check=True)
    
    print("Catalog app build complete.")

if __name__ == "__main__":
    build_catalog_app()