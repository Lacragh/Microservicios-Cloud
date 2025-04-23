import random
from behave import when, then
from pages.todos_page import TodosPage

@when('a new todo item is added')
def add_new_todo_item(context):
    context.todos_page = TodosPage(context.driver)
    context.todos_page.add_todo_item("New Todo Item"+str(random.randint(1, 100)))

@then('the todo item should be displayed in the list')
def is_todo_item_present(context):
    assert context.todos_page.is_todo_item_present(), "Todo item not found in the list"