from behave import given, when
import os
from pages.login_page import LoginPage
from pages.todos_page import TodosPage


@given('the user is on the login page')
def step_given_user_on_login_page(context):
    app_ip = os.getenv("APP_IP", "127.0.0.1")
    context.driver.get(f"http://{app_ip}:8080/#/login")
    context.login_page = LoginPage(context.driver)
    

@when('the proceed button is displayed')
def step_then_proceed_button_displayed(context):
    pass
    #context.login_page.proceed()

@when('the user logs in with valid credentials')
def step_when_user_logs_in_valid(context):
    context.login_page.login("admin", "admin")
    context.todos_page = TodosPage(context.driver)

