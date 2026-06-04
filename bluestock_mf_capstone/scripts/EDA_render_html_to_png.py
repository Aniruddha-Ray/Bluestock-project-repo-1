import os
from pathlib import Path
import imgkit
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time

# Define paths
html_dir = r"C:\Users\Asus\OneDrive\Desktop\Bluestock_intern\Bluestock-project-repo-1\bluestock_mf_capstone\reports\EDA plots"
output_dir = r"C:\Users\Asus\OneDrive\Desktop\Bluestock_intern\Bluestock-project-repo-1\bluestock_mf_capstone\reports\EDA plots\png_outputs"

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Get all HTML files
html_files = list(Path(html_dir).glob("*.html"))

print(f"Found {len(html_files)} HTML files to convert")

# Configure Chrome options for headless rendering
chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
chrome_options.add_argument("--start-maximized")

for html_file in html_files:
    try:
        output_filename = html_file.stem + ".png"
        output_path = os.path.join(output_dir, output_filename)
        
        # Initialize Chrome driver
        driver = webdriver.Chrome(options=chrome_options)
        
        # Load HTML file
        file_url = f"file:///{html_file}".replace("\\", "/")
        driver.get(file_url)
        
        # Wait for page to fully load
        time.sleep(2)
        
        # Get page dimensions
        total_width = driver.execute_script("return document.body.scrollWidth")
        total_height = driver.execute_script("return document.body.scrollHeight")
        
        # Set window size
        driver.set_window_size(total_width, total_height)
        time.sleep(1)
        
        # Take screenshot
        driver.save_screenshot(output_path)
        driver.quit()
        
        print(f"✓ Converted: {html_file.name} -> {output_filename}")
        
    except Exception as e:
        print(f"✗ Error converting {html_file.name}: {str(e)}")
        try:
            driver.quit()
        except:
            pass

print("Conversion complete!")
