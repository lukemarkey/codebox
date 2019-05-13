from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from user.models import User

class CustomUserAdmin(UserAdmin):
    model = User
    fieldsets = UserAdmin.fieldsets

admin.site.register(User, CustomUserAdmin)
