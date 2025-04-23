from selenium.webdriver.common.by import By
from pages.base_page import BasePage

class LoginPage(BasePage):
    USERNAME_INPUT = (By.NAME, "username")  # Changed to use 'name'
    PASSWORD_INPUT = (By.NAME, "password")  # Changed to use 'name'
    LOGIN_BUTTON = (By.CSS_SELECTOR, "button[type='submit']")  
    PROCEED_BUTTON = (By.ID, "proceed-button")    # Changed to use 'type'

    def proceed(self):
        self.wait_for_element(self.PROCEED_BUTTON)
        self.click(self.PROCEED_BUTTON)

    def login(self, username, password):
        self.type(self.USERNAME_INPUT, username)
        self.type(self.PASSWORD_INPUT, password)
        self.click(self.LOGIN_BUTTON)

