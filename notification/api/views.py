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

from rest_framework.authtoken.models import Token

import django_filters





from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)

from notification.models import (
	Notification
)





from notification.api.serializers import (
	CreateNotificationSerializer,
	NotificationSerializer
)




@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def create_notification_view(request):

	if request.method == 'POST':
		print(request.data)
		data = {}
		user = request.user
		rdata = request.data.copy()
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else: 
			data["response"] = "Error"
			data["error_message"] = "permission denied"
			return Response(data=data, status=400)




		rdata["organization"] = organization.pk

		serializer = CreateNotificationSerializer(data=rdata)



		if serializer.is_valid():
			notification = serializer.save()
			data["response"] = "successfull"
			data["error_message"] = None
			return Response(data=data)
		else :
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)





class ApiNotificationListView(ListAPIView):
	serializer_class = NotificationSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = (DjangoFilterBackend, OrderingFilter,)

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.is_teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Notification.objects.filter(organization=organization).order_by("-pk")



@api_view(['GET', ])
@permission_classes([IsAuthenticated])
def notification_details_view(request, pk):

	if request.method == 'GET':
		print(request.data)
		data = {}
		user = request.user

		
		try :
			notification = Notification.objects.get(pk=pk)
			print(notification)
			notification.reads.add(user.pk)
			notification.save()
		except :
			print("dklsfjsdlak")
			data["response"] = "Error"
			data["error_message"] = "Not found"
			return Response(data=data, status=400)




		serializer = NotificationSerializer(notification)
		return Response(serializer.data)