from dataclasses import field
from rest_framework import serializers

from notification.models import (
	Notification
)


from rest_framework.exceptions import ValidationError

class CreateNotificationSerializer(serializers.ModelSerializer) :

	class Meta :

		model = Notification
		fields = [
			"organization",
			"title",
			"description",
			"image"
		]


class NotificationSerializer(serializers.ModelSerializer) :

	is_read                     = serializers.SerializerMethodField("get_is_read")
	class Meta :

		model = Notification
		fields = [
			"pk",
			"title",
			"description",
			"image",
			"created_at",
			"updated_at",
			"is_read"
		]


	def get_is_read(self, obj):
		request = self.context.get("request", None)
		if request :
			user = request.user
			if obj.reads.filter(pk=user.pk).exists():
				return True
			else :
				# obj.reads.add(user.pk)
				return False
		else :


			return True
			# data = {}
			# data["response"] = "Error"
			# data["error_message"] = "Unauthenticated"
			# raise ValidationError(data)