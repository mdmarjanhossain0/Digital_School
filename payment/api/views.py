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





@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def student_payment_view(request):

	if request.method == 'POST':

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


		serializer = PaymentSerializer(data=rdata)

		if serializer.is_valid():

			serializer.save()
			data["response"] = "Successfully payment"
			data["error_message"] = None
			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)


class ApiReportView(ListAPIView):
	serializer_class = PaymentSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {'account', 'note'}
	filterset_fields =  {'account', 'note'}


	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Payments.objects.filter(organization=organization)