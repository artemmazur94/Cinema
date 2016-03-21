using System.Web.Mvc;
using System.Web.Mvc.Html;
using Antlr.Runtime.Misc;

namespace Cinema.Web.Helpers
{
    public static class CustomHtmlHelpers
    {
        public static MvcHtmlString PartialFor<TModel, TProperty>(this HtmlHelper<TModel> helper, System.Linq.Expressions.Expression<Func<TModel, TProperty>> expression, string partialViewName)
        {
            string name = ExpressionHelper.GetExpressionText(expression);
            object model = ModelMetadata.FromStringExpression(expression.ToString(), helper.ViewData).Model;
            var viewData = new ViewDataDictionary(helper.ViewData)
            {
                TemplateInfo = new TemplateInfo
                {
                    HtmlFieldPrefix = name
                }
            };
            return helper.Partial(partialViewName, model, viewData);
        }
    }
}