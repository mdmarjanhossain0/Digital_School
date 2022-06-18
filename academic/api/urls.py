from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token


from academic.api.views import(

	create_course_view,
	create_exam_view,
	create_result_view,

	update_course_view,
	update_exam_view,
	update_result_view,

	ApiCourseListView,
	ApiExamListView,

	student_indivisula_result_view,
	exam_result_view
	) 

app_name='academic'

urlpatterns = [
	path("course/create", create_course_view, name=""),
	path("exam/create", create_exam_view, name=""),
	path("result/create", create_result_view, name=""),

	path("course/update/<pk>", update_course_view, name=""),
	path("exam/update/<pk>", update_exam_view, name=""),
	path("result/update/<pk>", update_result_view, name=""),

	path("course", ApiCourseListView.as_view(), name=""),
	path("exam", ApiExamListView.as_view(), name=""),

	path("result/<exam_pk>/<student_pk>", student_indivisula_result_view, name=""),
	path("result/<pk>", exam_result_view, name="")
]