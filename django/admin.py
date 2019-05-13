from django.contrib import admin

from website.models import Page, PageContent, Inventory

###########################################################################
## INLINE CLASS FOR LISITNG OBJECTS RELATED TO PARENT
###########################################################################

class PageContentInline(admin.TabularInline):

	model = PageContent
	readonly_fields = ['name']
	can_delete = False

###########################################################################
## MODELS AVAILABLE ON THE ADMIN DASHBOARD
###########################################################################

@admin.register(Page)
class PageAdmin(admin.ModelAdmin):

	inlines = [ PageContentInline ]
	exclude = ('title', 'description',)

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


