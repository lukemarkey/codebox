from django.contrib import admin

from website.models import Page, PageContent, Inventory

###########################################################################
## INLINE CLASS FOR LISITNG OBJECTS RELATED TO PARENT
###########################################################################

class PageContentInline(admin.TabularInline):

	model = PageContent
	fields = ['name', 'heading', 'subheading', 'content', 'link', 'image']
	readonly_fields = ['name']
	can_delete = False

	def has_add_permission(self, request, obj=None):
		return False

###########################################################################
## MODELS AVAILABLE ON THE ADMIN DASHBOARD
###########################################################################

@admin.register(Page)
class PageAdmin(admin.ModelAdmin):

	inlines = [ PageContentInline ]
	readonly_fields = ['name', 'slug']
	can_delete = False

@admin.register(Inventory)
class InventoryAdmin(admin.ModelAdmin):

	exclude = ('slug',)

	fieldsets = (
		('Summary', {
			'fields': ( ('name', 'title'), 'content' )
		}),
		('Multimedia', {
			'fields': ( 'thumbnail', 'gallery' )
		})
	)


