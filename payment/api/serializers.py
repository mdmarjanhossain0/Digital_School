from rest_framework import serializers

from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)




from academic.models import (
	Course,
	Exam,
	Result
)





from payment.models import (
	Payments
)



class PaymentSerializer(serializers.ModelSerializer):

	username = serializers.SerializerMethodField("get_username")

	class Meta:

		model = Payments

		fields = [
			"organization",
			"pk",
			"account",
			"note",
			"fee",
			"fine",
			"discount",
			"created_at",
			"updated_at",
			 "username"
			 ]

	def get_username(self, obj):
		if obj.account:
			return obj.account.username
		else:
			return None
		