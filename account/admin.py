from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)


class AccountAdmin(UserAdmin):
	list_display=('email', 'mobile', 'username','date_joined','last_login','is_admin','is_staff')
	search_fields=('email','username')
	readonly_fields=('date_joined','last_login')

	filter_horizontal=()
	list_filter=()
	fieldsets=()

admin.site.register(Account,AccountAdmin)
admin.site.register(Organization)
admin.site.register(Staff)
admin.site.register(Batch)
admin.site.register(Student)
admin.site.register(Teacher)
admin.site.site_header = 'Digital Pharmacy Administration'