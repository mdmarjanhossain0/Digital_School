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
    StaffPayment,
    StudentPayment,
    TeacherPayment,
    OtherPayment
)




class StaffPaymentSerializer(serializers.ModelSerializer):

    class Meta:

        model = StaffPayment

        fields = "__all__"



class StudentPaymentSerializer(serializers.ModelSerializer):

    class Meta:

        model = StudentPayment

        fields = "__all__"

class TeacherPaymentSerializer(serializers.ModelSerializer):

    class Meta:

        model = TeacherPayment

        fields = "__all__"





class OtherPaymentSerializer(serializers.ModelSerializer):

    class Meta:

        model = OtherPayment

        fields = "__all__"