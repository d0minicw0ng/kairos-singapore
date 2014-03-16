function CommentsListViewModel() {
    var self = this;

    self.hasComments = function() {
        return $('ul.comments-container li.comment').length > 0;
    }
}

