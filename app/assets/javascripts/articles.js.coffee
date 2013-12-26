# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
  $('body.articles-edit, body.articles-new').each ->
    articlePreview = $('.article-preview')
    $('#article_content').on 'input', ->
      articlePreview.html marked @value
