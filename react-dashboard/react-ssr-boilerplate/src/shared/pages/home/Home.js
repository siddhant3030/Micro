import React, { Component } from "react";
import AppHeader from "../../components/AppHeader";
import AppFooter from "../../components/AppFooter";
import PageContent from "../../components/PageContent";
import Users from "../../components/Users";
import TopUsers from "../../components/TopUsers";
// import HideText from "../../components/HideText";

class Home extends Component {

  constructor(props){
    super(props);
    this.state = {
      activeTab:'users',
      topUsers:[]
    }
  }

  componentDidMount() {
  }

  getTopUsers = (users)=>{
    this.setState({topUsers:users});
    console.log("new user",users)
  }

  render() {

    let activeComponent = this.state.activeTab=='users'? <Users getTopUsers={this.getTopUsers}/> : <TopUsers topUsers={this.state.topUsers}/>;
    return (
        <div className="container-fluid">
          <div className="sidenav">
            <a href="#home">Home</a>
            <a href="#sports">Sports</a>
            <a href="#news">News</a>
            <a href="#logout">Logout</a>
          </div>
          <div className="main">
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
        </div>

    );
  }
}



export default Home;
