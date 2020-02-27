import React, { Component } from "react";
import AppHeader from "../../components/AppHeader";
import AppFooter from "../../components/AppFooter";
import PageContent from "../../components/PageContent";

class Home extends Component {

  constructor(props){
    super(props);
    this.state = {
      activeTab:'users'
    }
  }

  componentDidMount() {

  }

  render() {

    let activeComponent = this.state.activeTab=='users'? 'users' :'topusers'
    return (
        <div className="container-fluid">
          <AppHeader />
          <ul className="nav nav-tabs">
            <li className="nav-item">
              <div className={`nav-link ${this.state.activeTab=='users'?'active':''}`} onClick={()=>this.setState({activeTab:'users'})}>Users</div>
            </li>
            <li className="nav-item">
              <div className={`nav-link ${this.state.activeTab=='topUsers'?'active':''}`} onClick={()=>this.setState({activeTab:'topUsers'})}>Top Users</div>
            </li>
          </ul>
          <PageContent>
            {activeComponent}
          </PageContent>
          <AppFooter />
        </div>

    );
  }
}



export default Home;
