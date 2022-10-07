from functools import partial
from django.http import request
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework.generics import UpdateAPIView
from django.contrib.auth import authenticate, login
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from rest_framework.decorators import api_view, authentication_classes, permission_classes

from rest_framework.generics import ListAPIView
from rest_framework.filters import SearchFilter, OrderingFilter
from rest_framework.pagination import PageNumberPagination
from rest_framework.generics import ListAPIView
from django_filters.rest_framework import DjangoFilterBackend
import django_filters


from rest_framework.pagination import PageNumberPagination

from datetime import datetime

from django.db.models import Sum

from operator import attrgetter

import operator
from django.db.models import Q




from django.db import connection, transaction




from rest_framework.exceptions import ValidationError

from decimal import *





from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)

from payment.models import Payments

from payment.api.serializers import (
	PaymentSerializer
)



def sql_select(sql):
	cursor = connection.cursor()
	cursor.execute(sql)
	results = cursor.fetchall()
	list = []
	i = 0
	for row in results:
		dict = {} 
		field = 0
		while True:
			try:
				dict[cursor.description[field][0]] = str(results[i][field])
				field = field + 1
			except IndexError as e:
				break
		i = i + 1
		list.append(dict) 
	return list  

STUDENT_PAYMENT = "Student Payment"
TEACHER_PAYMENT = "Teacher Payment"
STAFF_PAYMENT = "Staff Payment"
OTHER = "Other"

@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def student_payment_view(request):

	if request.method == 'POST':


		print(request.data)

		data = {}
		if request.user.is_admin:
			organization = Organization.objects.get(account=request.user)
		elif request.user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		rdata = request.data.copy()
		rdata["organization"] = organization.pk

		try :
			type = rdata.get("type", None)
			if type == STUDENT_PAYMENT:
				rdata["account"] = Student.objects.get(pk=request.data["account"]).account.pk
			elif type == TEACHER_PAYMENT:
				tea = Teacher.objects.get(pk=request.data["account"]).account.pk
				print(tea)
				rdata["account"] = tea
			elif type == STAFF_PAYMENT:
				rdata["account"] = Staff.objects.get(pk=request.data["account"]).account.pk
			elif type == OTHER:
				rdata["account"] = None
			else :
				data["response"] = "Error"
				data["error_message"] = "Type is required"
				return Response(data=data, status=400)

		except :
			data["response"] = "Error"
			data["error_message"] = "Account not found"
			return Response(data=data, status=400)


		serializer = PaymentSerializer(data=rdata)

		if serializer.is_valid():

			payment = serializer.save()

			if payment.account :
				account = payment.account


				if account.is_admin :
					# organization = Organization.objects.get(account=user)
					pass
				elif account.is_staff:
					staff = Staff.objects.get(account=account)
					staff.balance = Decimal(staff.balance) + Decimal(payment.fee) - Decimal(payment.fine) + Decimal(payment.discount)
					staff.save()
				elif account.is_teacher:
					teacher = Teacher.objects.get(account=account)
					teacher.balance = Decimal(teacher.balance) + Decimal(payment.fee) - Decimal(payment.fine) + Decimal(payment.discount)
					teacher.save()
				else: 
					student = Student.objects.get(account=account)
					student.balance = Decimal(student.balance) + Decimal(payment.fee) - Decimal(payment.fine) + Decimal(payment.discount)
					student.save()


			data["response"] = "Successfully payment"
			data["error_message"] = None
			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)




# class ReportFilter(django_filters.FilterSet):
# 	brand_name= django_filters.CharFilter(lookup_expr='startswith')
# 	generic= django_filters.CharFilter(lookup_expr='startswith')
# 	manufacture= django_filters.CharFilter(lookup_expr='startswith')
# 	class Meta:
# 		model= PaymentSerializer
# 		fields = ["brand_name", "generic", 'manufacture']

class ApiReportView(ListAPIView):
	serializer_class = PaymentSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {'account', 'note'}
	filterset_fields =  {'account', 'note'}


	def get_queryset(self):
		data = {}
		start = self.request.GET.get("start", None)
		end = self.request.GET.get("end", None)
		query = self.request.GET.get("query", "")

		if query == "All":
			query = ""

		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		else: 
			print("user not admin")
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			raise ValidationError(data)

		try :
			start_date = datetime.strptime(start, "%Y-%m-%d")
			end_date = datetime.strptime(end, "%Y-%m-%d")
			range = (
					datetime.combine(start_date, datetime.min.time()),
					datetime.combine(end_date, datetime.max.time())
			)
			query_set = Payments.objects.filter(
				Q(type__icontains=query),
				organization=organization, 
				created_at__range=range,
				).order_by("-pk")
		except :
			print("exception")
			query_set = Payments.objects.filter(
				Q(type__icontains=query),
				organization=organization
				).order_by("-pk")
		return query_set









@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def report_list_api_view(request, start=None, end=None, page=1):
	if request.method == "GET":


		data = {}
		start = request.GET.get("start", None)
		end = request.GET.get("end", None)
		query = request.GET.get("query", None)

		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		try :
			start_date = datetime.strptime(start, "%Y-%m-%d")
			end_date = datetime.strptime(end, "%Y-%m-%d")
			range = (
					# The start_date with the minimum possible time
					datetime.combine(start_date, datetime.min.time()),
					# The start_date with the maximum possible time
					datetime.combine(end_date, datetime.max.time())
			)
			query_set = Payments.objects.filter(
				organization=organization, 
				created_at__range=range,
				type=query
				).order_by("-pk").distinct()
		except :
			print("exception")
			query_set = Payments.objects.filter(
				organization=organization, 
				).order_by("-pk").values_list()
	
		paginator = PageNumberPagination()
		paginator.page_size = 20
		result_page = paginator.paginate_queryset(query_set, request)
		print(result_page)
		test = Payments.objects.all()
		serializer = PaymentSerializer(data=test, many=True)
		if serializer.is_valid():
			print(type(serializer.data))
			return paginator.get_paginated_response(serializer.data)


		print("not va")
		# print(serializer.data)
		print(serializer.errors)

		return Response(data={"data" : "dfsdfsd"})


custom_months = {
	1 : "January",
	2 : "February",
	3 : "March",
	4 : "April",
	5 : "May",
	6 : "June",
	7 : "July",
	8 : "August",
	9 : "September",
	10 : "October",
	11 : "November",
	12 : "December"
}
def all_month_checker(data):
	new_data = []
	for item in range(1, 13):
		exist = False
		new_item = {}
		for inner_item in data:
			if inner_item["month_number"] == str(item):
				new_item["month"] = custom_months.get(item, "")
				new_item["total"] = inner_item["total"]
				new_item["students"] = inner_item.get("students", 0)
				exist = True
				new_data.append(new_item)
		if not exist :
			new_item["month"] = custom_months.get(item, None)
			new_item["total"] = 0
			new_item["students"] = 0
			new_data.append(new_item)
	return new_data

				
				


@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def students_count_graph_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query = "SELECT MONTH(created_at) AS month_number, COUNT(*) AS total FROM account_student WHERE organization_id = {organization_id} AND YEAR(created_at) = {year} GROUP BY MONTH(created_at)"
		year = datetime.now().year
		print(year)
		data = sql_select(query.format(
			organization_id = organization.id,
			year = year
		))
		# students = []
		# for item in data:
		# 	data = {}
		# 	data["month_number"] = item.month_number
		# 	data["total"] = item.total
		# 	students.append(data)

		return Response(all_month_checker(data))



@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def students_payment_graph_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query = "SELECT MONTH(created_at) AS month_number, COUNT(*) AS students, SUM(fee) + SUM(fine) - SUM(discount) AS total FROM payment_payments WHERE organization_id = {organization_id} AND type = 'Student Payment' AND YEAR(created_at) = {year} GROUP BY MONTH(created_at);"
		year = datetime.now().year
		print(year)
		data = sql_select(query.format(
			organization_id = organization.id,
			year = year
		))
		return Response(all_month_checker(data=data))

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def count_members_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query = "SELECT (SELECT COUNT(*) FROM account_student WHERE organization_id = {organization_id}) AS students, (SELECT COUNT(*) FROM account_teacher WHERE organization_id = {organization_id}) AS teachers, (SELECT COUNT(*) FROM account_staff WHERE organization_id = {organization_id}) AS staffs;"
		data = sql_select(query.format(
			organization_id = organization.pk
		))
		return Response(data[0])







@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def student_payment_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query = "SELECT MONTH(created_at) AS month_number, COUNT(*) AS students, SUM(fee) + SUM(fine) - SUM(discount) AS total FROM payment_payments WHERE organization_id = {organization_id} AND type = 'Student Payment' AND YEAR(created_at) = {year} GROUP BY MONTH(created_at);"
		year = datetime.now().year
		print(year)
		data = sql_select(query.format(
			organization_id = organization.id,
			year = year
		))

		current_month_payment = {
			"month" : custom_months.get(int(data[-1].get("month_number")), 1),
			"total" : data[-1].get("total", 0)
		}
		print(current_month_payment)
		s_data = all_month_checker(data=data)
		return Response(
			{
				"current_month_payment" : current_month_payment,
				"current_year_payment" : s_data
			}
		)


@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def student_payment_and_due_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query_payment = "SELECT MONTH(created_at) AS month_number, COUNT(*) AS students, SUM(fee) + SUM(fine) - SUM(discount) AS total FROM payment_payments WHERE organization_id = {organization_id} AND type = 'Student Payment' AND YEAR(created_at) = {year} GROUP BY MONTH(created_at);"
		year = datetime.now().year
		print(year)
		data = sql_select(query_payment.format(
			organization_id = organization.id,
			year = year
		))
		current_month_payment = {
			"month" : custom_months.get(int(data[-1].get("month_number")), 1),
			"total" : data[-1].get("total", 0)
		}
		s_payment_data = all_month_checker(data=data)





		query_due = "SELECT MONTH(created_at) AS month, COUNT(*) AS students, SUM(balance) AS total FROM account_student WHERE organization_id = {organization_id} AND balance < 0 GROUP BY MONTH(created_at)"
		s_due_data = sql_select(query_due.format(
			organization_id = organization.id
		))
		print(s_due_data)

		return Response(
			{
				"current_month_payment" : current_month_payment,
				"current_year_payment" : s_payment_data,
				"due" : s_due_data
			}
		)







@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def organization_expance_api(request):
	if request.method == "GET":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		query_payment = "SELECT MONTH(created_at) AS month_number, COUNT(*) AS students, SUM(fee) - SUM(fine) + SUM(discount) AS total FROM payment_payments WHERE organization_id = {organization_id} AND type != 'Student Payment' AND YEAR(created_at) = {year} GROUP BY MONTH(created_at);"
		year = datetime.now().year
		print(year)
		data = sql_select(query_payment.format(
			organization_id = organization.id,
			year = year
		))
		current_month_expance = {
			"month" : custom_months.get(int(data[-1].get("month_number")), 1),
			"total" : data[-1].get("total", 0)
		}
		s_expance_data = all_month_checker(data=data)

		return Response(
			{
				"current_month_expance" : current_month_expance,
				"current_year_expance" : s_expance_data
			}
		)