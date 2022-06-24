from django.contrib import admin

from payment.models import (
    StaffPayment,
    StudentPayment,
    TeacherPayment,
    OtherPayment
)






admin.site.register(StaffPayment)
admin.site.register(StudentPayment)
admin.site.register(TeacherPayment)
admin.site.register(OtherPayment)