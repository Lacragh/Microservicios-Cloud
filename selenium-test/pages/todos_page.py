from selenium.webdriver.common.by import By
from pages.base_page import BasePage

class TodosPage(BasePage):
    TODOS_INPUT = (By.CSS_SELECTOR, "input[placeholder='New task']")
    ADD_BUTTON = (By.CSS_SELECTOR, "button[type='submit']")
    TODOS_LIST_ITEMS = (By.CSS_SELECTOR, "div.col-sm-11.text-left")
    new_todo =""

    def add_todo_item(self, item_text):
        self.type(self.TODOS_INPUT, item_text)
        self.click(self.ADD_BUTTON)
        self.new_todo = item_text

    def is_todo_item_present(self):

        todos = self.driver.find_elements(*self.TODOS_LIST_ITEMS)
        for todo in todos:
            if self.new_todo in todo.text:
                return True
        return False