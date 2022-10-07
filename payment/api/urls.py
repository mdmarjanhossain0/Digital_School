from django.urls import path

from payment.api.views import(
    student_payment_view,
    ApiReportView,
    report_list_api_view,








    students_count_graph_api,

    count_members_api,
    students_payment_graph_api,
    student_payment_api,
    student_payment_and_due_api,




    organization_expance_api
	) 

app_name='payment'

urlpatterns = [
	path('student/create', student_payment_view, name=""),
    path("student", ApiReportView.as_view(), name=""),


    path("student_graph", students_count_graph_api, name=""),
    path("student_payment_graph", students_payment_graph_api, name=""),
    path("count_members", count_members_api, name=""),
    path("student_payment", student_payment_api, name=""),
    path("student_payment_due", student_payment_and_due_api, name=""),





    path("organization_expance", organization_expance_api, name="")
]
