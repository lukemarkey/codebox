###########################################################################
## DJANGO ROOT URL SCAFFOLD
###########################################################################

from django.contrib import admin
from django.urls import path
from django.conf.urls import url, include

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
	path('', include('website.urls')),
    path('admin/', admin.site.urls),
]

if settings.DEBUG is True:
	urlpatterns +=  static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

###########################################################################
## DJANGO APP URL SCAFFOLD
###########################################################################

from django.conf.urls import url
from django.urls import path

from website import views

urlpatterns = [
	path('', views.HomePageView.as_view(), name='home'),
]
