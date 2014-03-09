function NewCommentViewModel(userId) {
    var self = this;
    self.userId = userId;
    self.commentableType = $('form#new_comment').data('commentable-type');
    self.commentableId = $('form#new_comment').data('commentable-id');
    self.content = ko.observable();

    self.submitComment = function() {
        var data = {
            comment: {
                user_id: self.userId,
                content: self.content(),
                commentable_type: self.commentableType,
                commentable_id: self.commentableId
            }
        };
        var url = '/' + self.commentableType.toLowerCase() + 's' + '/' + self.commentableId + '/' + 'comments';

        $.post(url, data, function(comment) {
            var listItem = HandlebarsTemplates['comments/show']({
              comment: comment
            });
            $('ul.comments').append(listItem);
            $('input#comment_content').val('');
        });
    }
}

