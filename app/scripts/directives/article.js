/* 博客指令文件 */

// Markdown编辑器
BlogDirectives.directive("mdEditor", ['$compile', function($compile){
    var nextId = 0;
    var markdownConverter = new Markdown.Converter();
    return {
        require: 'ngModel',
        replace: true,
        template: '<div class="pagedown-bootstrap-editor"></div>',
        link: function(scope, iElement, iAttrs, ngModel) {
            var editorUniqueId = nextId++;
            var newElement = $compile('<div>' + '<div class="wmd-panel" ng-show="postArgs.isEdit">' + '<div id="wmd-button-bar-' + editorUniqueId + '"></div>' + '<textarea class="wmd-input form-control" rows="30" id="wmd-input-' + editorUniqueId + '" ng-model="article.articleContent" placeholder="请输入文章内容">' + '</textarea>' + '</div>' + '<div id="wmd-preview-' + editorUniqueId + '" class="wmd-panel wmd-preview" ng-hide="postArgs.isEdit"></div>' + '</div>')(scope);
            iElement.html(newElement);
            // 初始化
            var converter = new Markdown.Converter();
            var editor = new Markdown.Editor(converter, "-" + editorUniqueId);
            editor.run();

            var $wmdInput = $("#wmd-input-" + editorUniqueId);

            // 实现预览
            $wmdInput.on('change', function() {
                var rawContent = $wmdInput.val();
                scope.$apply(function() {
                    ngModel.$setViewValue(rawContent);
                });
            });

            scope.$watch(iAttrs.ngModel, function(value, oldValue) {
                // console.log('ngModel changed', 'old: ', oldValue, 'new: ', value, editor, $wmdInput);
                if(value){
                    $wmdInput.val(value);
                    editor.refreshPreview(); // forces the editor to re-render the preview according to the contents of the input, e.g. after you have programmatically changed the input box content. This method is only available after editor.run() has been called.
                }

            });
        }
    }
}])
// 博客列表(包含分页)
.directive("articleList",['$compile','$interval', '$location', 'starArticle', function($compile, $interval, $location, starArticle){
    return { 
        restrict: 'AE',
        replace: true,
        scope: { articles:'=' ,paginate:'=' },
        templateUrl: '/scripts/directives/partials/articleList.html',
        link: function(scope, iElement, iAttrs){
          // 翻页跳转
          scope.pageChanged = function (pageNo) {
            $location.path("/blog/page/" + pageNo);
          };
          // Star the blog.
          scope.starArticle = starArticle;
        }
    }
}])
// 博客内容展示
.directive("articleContent", ["$compile", function($compile){
    return {
        restrict: 'A',
        replace: true,
        scope: { content:'='},
        template: '<p class="article_content"></p>',
        link: function(scope, iElement, iAttrs){
            // 取前10个元素进行预览
            var content = $compile(scope.content)(scope),
                myArticle = iElement;
            
            for(var i = 0; i < 5; i++){
                myArticle.append(content.eq(i));
            }
            iElement.append(myArticle);
        }
    }
}])