from django.urls import path

from payment.api.views import(
    student_payment_view,
    ApiReportView,
    report_list_api_view
	) 

app_name='payment'

urlpatterns = [
	path('student/create', student_payment_view, name=""),

    path("student", ApiReportView.as_view(), name="")
]
