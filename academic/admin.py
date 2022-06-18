from django.contrib import admin

from academic.models import (
    Course,
    Exam,
    Result
)







admin.site.register(Course)
admin.site.register(Exam)
admin.site.register(Result)