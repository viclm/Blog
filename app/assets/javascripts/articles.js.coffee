# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
  $('body.articles-edit, body.articles-new').each ->
    articleEdit = $('#article_content')
    articlePreview = $('.article-preview')
    articleEdit.on 'input', ->
      articlePreview.html marked @value
    articleEdit.trigger 'input'
