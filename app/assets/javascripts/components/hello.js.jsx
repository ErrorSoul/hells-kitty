var Category = React.createClass({
  handleSubmit: function() {
    console.log(this.props.category.name);
    console.log(this.props.category)
    this.props.onUpdate(this.props.category);
  },
  render: function(){
    return (
      <li onClick={this.handleSubmit}><p> {this.props.category.name} </p> </li>
    )
  }
})

var BreadCrumb = React.createClass({
    handleSubmit: function() {
	console.log(this.props.category.name, 'breadcrumb');
	this.props.changeCategory(this.props.category);
    },

    render: function() {
	return (
		<span onClick={this.handleSubmit}>/{this.props.category.name} </span>
	)
    }
})

var BreadCrumbPanel = React.createClass({
    create: function (category) {
	var categoriesFlatten = this.props.categories;
	var makePath = function (result, category, categoriesFlatten ) {

	    if (category.parent_id) {
		result.unshift(category);
		console.log('if result', result);
		var find_category = _.find(categoriesFlatten, function(cat) {return category.parent_id == cat.id});
		console.log('find_category', find_category);
		makePath(result, find_category, categoriesFlatten);

	    }
	    else {result.unshift(category)}
	    return result;
	}
	return makePath([], category, categoriesFlatten);

    },

    onChangeCategory: function(category) {
	this.props.onChangeCategory(category);
    },

    render: function() {
	var changeCategory = this.onChangeCategory;
	var paths = this.create(this.props.category);

	var p = _.map(paths, function(path){
	    return( <BreadCrumb category={path} changeCategory={changeCategory} />);
	})
	return (<p> {p} </p>)
    }
})

var CategoryList = React.createClass({
    getInitialState: function() {
	var flatten = function(array, result) {
	    _.each(array, function(element) {
		if(element.children) {
		    result.push(element);
		    flatten(element.children, result);
		} else {
+		    result.push(element);
		}
	    })
	   return result;

	}
	var categoriesFlatten  = flatten(this.props.data, []);
	console.log("categories flatten", categoriesFlatten );
	return {
	    data: this.props.data,
	    categories: categoriesFlatten,
	    category: {}
	};
    },

    componentDidMount: function () {

	console.log('flatten');

    },
  onClick: function (category) {
      console.log(category, 'category');
      this.setState({ data: (category.children || this.state.data), category: category});
      console.log(this.state, 'state');
  },

  render: function() {
    var onClick = this.onClick.bind(this);
    var categories = this.state.data.map(function(category){
      return (<Category category={category} onUpdate={onClick}/>)
    })

      return (
	  <div>
	      <BreadCrumbPanel onChangeCategory={onClick} category={this.state.category} categories={this.state.categories}/>
	      <ul>{categories}</ul>
	  </div>
      )
  }
})
