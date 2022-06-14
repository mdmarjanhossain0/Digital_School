from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

from account.api.views import(
	registration_organization_view,
	registration_staff_view,
	registration_student_view,
	registration_teacher_view
	) 

app_name='account'

urlpatterns = [
	path("register", registration_organization_view, name="register"),
	path("register/staff", registration_staff_view, name="register_staff"),
	path("register/student", registration_student_view, name="register_student"),
	path("register/teacher", registration_teacher_view, name="register_teacher"),
]