from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

from notification.api.views import(
    create_notification_view,
    ApiNotificationListView,
    notification_details_view
	) 

app_name='notification'

urlpatterns = [
	path('create', create_notification_view, name=""),
    path("list", ApiNotificationListView.as_view(), name=""),
    path("list/<pk>", notification_details_view, name="")
]
