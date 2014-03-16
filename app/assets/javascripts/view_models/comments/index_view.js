function CommentsListViewModel() {
    var self = this;

    self.commentsLength = function() {
        return $('ul.comments-container li.comment').length;
    }
}

