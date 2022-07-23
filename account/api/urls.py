from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

from account.api.views import(
	ObtainAuthTokenView,
	delete_batch_view,

	delete_staff_view,
	delete_student_view,
	delete_teacher_view,
	registration_organization_view,
	registration_staff_view,
	registration_student_view,
	registration_teacher_view,
	student_profile_view,

	update_organization_view,
	update_staff_view,
	update_student_view,
	update_teacher_view,



	ApiStaffListView,
	ApiStudentListView,
	ApiTeacherListView,





	delete_staff_view,
	delete_student_view,
	delete_teacher_view,


	staff_details_view,
	student_details_view,
	teacher_details_view,

	ApiBatchListView,
	create_batch_view,
	update_batch_view,
	delete_batch_view,

	student_profile_view,


	ChangePasswordView,
	update_profile_view
	) 

app_name='account'

urlpatterns = [
	path('login', ObtainAuthTokenView.as_view(), name="login"), 

	
	path("register", registration_organization_view, name="register"),
	path("register/staff", registration_staff_view, name="register_staff"),
	path("register/student", registration_student_view, name="register_student"),
	path("register/teacher", registration_teacher_view, name="register_teacher"),
	path("batch/create", create_batch_view, name="register"),



	path("profile/update", update_profile_view, name="register"),
	path("organizer/update/<pk>", update_organization_view, name="register"),
	path("staff/update/<pk>", update_staff_view, name="register"),
	path("student/update/<pk>", update_student_view, name="register"),
	path("teacher/update/<pk>", update_teacher_view, name="register"),
	path("batch/update/<pk>", update_batch_view, name="register"),

	path("staff/<pk>", staff_details_view, name="register"),
	path("student/<pk>", student_details_view, name="register"),
	path("teacher/<pk>", teacher_details_view, name="register"),

	path("student/profile/details", student_profile_view, name="register"),

	path("staff", ApiStaffListView.as_view(), name="register"),
	path("student", ApiStudentListView.as_view(), name="register"),
	path("teacher", ApiTeacherListView.as_view(), name="teacher"),
	path("batch", ApiBatchListView.as_view(), name=""),

	path("staff/delete/<pk>", delete_staff_view, name="delete"),
	path("student/delete/<pk>", delete_student_view, name="delete"),
	path("teacher/delete/<pk>", delete_teacher_view, name="delete"),
	path("batch/delete/<pk>", delete_batch_view, name="delete"),

	path('changepassword', ChangePasswordView.as_view(), name='changepassword'),
]