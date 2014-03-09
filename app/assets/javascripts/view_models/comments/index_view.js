function CommentsListViewModel() {
    var self = this;

    self.hasComments = function() {
        $('ul.comments li').length > 0;
    }
}

