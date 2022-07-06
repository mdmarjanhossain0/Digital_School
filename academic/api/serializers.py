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





class CourseSerializer(serializers.ModelSerializer):

	class Meta:

		model = Course
		fields = [
			"pk",
			"organization",
			"name",
			"is_available",
			"description"
		]

		# read_only_fields = ("pk",)
		# write_only_fields = ("organization",)
		extra_kwargs = {
			'organization': {'write_only': True},
			"pk": {"read_only": True}
		}

	
	
	
	
	# def update(self, instance, validated_data):

	# 	instance.name = validated_data.get("name", instance.name)
	# 	instance.name = validated_data.get("description", instance.name)
	# 	return instance

class ExamSerializer(serializers.ModelSerializer):

	class Meta:

		model = Exam
		fields = [
			"pk",
			"organization",
			"batch",
			"courses",
			"name",
			"schedule"
		]
		extra_kwargs = {
			'organization': {'write_only': True},
			"pk": {"read_only": True}
		}
		

	
	# def update(self, instance, validated_data):

	# 	instance.name = validated_data.get("name", instance.name)
	# 	return instance




class ExamListSerializer(serializers.ModelSerializer):

	courses 					= CourseSerializer(many=True)

	class Meta:

		model = Exam
		fields = [
			"pk",
			"organization",
			"batch",
			"courses",
			"name",
			"schedule"
		]
		extra_kwargs = {
			'organization': {'write_only': True},
			"pk": {"read_only": True}
		}






class ResultSerializer(serializers.ModelSerializer):

	class Meta:

		model = Result
		fields = [
			"pk",
			"organization",
			"exam",
			"student",
			"course",
			"mark"
		]
		extra_kwarg = {
			"course": {"required": True, "allow_blank": False}
		}
		

	
	# def update(self, instance, validated_data):

	# 	instance.exam = validated_data.get("exam", instance.exam)
	# 	instance.course = validated_data.get("course", instance.course)
	# 	instance.mark = validated_data.get("mark", instance.mark)
	# 	return instance