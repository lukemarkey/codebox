###########################################################################
## DJANGO ROOT URL SCAFFOLD
###########################################################################

from django.contrib import admin
from django.urls import path
from django.conf.urls import url, include

from django.conf import settings
from django.conf.urls.static import static

from django.contrib.sitemaps.views import sitemap
from root.sitemap import PageSitemap

sitemaps = {
	'pages': PageSitemap
}

urlpatterns = [
	path('', include('website.urls', namespace='website')),
    path('admin/', admin.site.urls),
    path('sitemap.xml/', sitemap, {'sitemaps': sitemaps}, name='django-contrib-sitemaps.views.sitemap')
]

## MAY NEED TO ADD FOR ASSET PATH DEBUGGING
if settings.DEBUG is True:
	urlpatterns +=  static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
	urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

###########################################################################
## DJANGO APP URL SCAFFOLD
###########################################################################

from django.conf.urls import url
from django.urls import path

from website import views

app_name = 'website'

urlpatterns = [
	path('', views.HomePageView.as_view(), name='home'),
	path('index-page/<slug>/', views.DetailPageView.as_view(), name='detail-page'),
]

###########################################################################
## URL PATTERNS
###########################################################################

urlpatterns = [
	path('', views.HomePageView.as_view(), name='home'), ## STANDARD PATH
	path('index-page/<slug>/', views.DetailPageView.as_view(), name='detail-page'), ## VARIABLE PATH
]
