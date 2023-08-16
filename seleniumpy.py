from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options

# Tu run selenium with headless mode
options = Options()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

WEB_URL = "https://www.palarniakawy.gorlice.pl/product/?kawa-bezkofeinowa"

# headless mode
driver = webdriver.Chrome(options)

# driver = webdriver.Chrome()


driver.get(WEB_URL)

wait = WebDriverWait(driver, 30)

availability_element_class = (
    'div[class="container-info"] div[title="Kawa bezkofeinowa"]'
)


try:
    # Wait for the availability element to appear
    availability_element = wait.until(
        EC.presence_of_element_located((By.CSS_SELECTOR, availability_element_class))
    )

    text_content = (
        availability_element.text
    )  # Use availability_element instead of availability_element_class

    print("Text content:", text_content.strip())
    print("Test passed")

except TimeoutException:
    print("Element did not appear within the specified time.")
