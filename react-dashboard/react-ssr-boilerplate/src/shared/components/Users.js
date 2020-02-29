import React, { Component } from 'react'
import Axios from 'axios';
// import "./users.css"



export default class Users extends Component {
    constructor(){
        super();
        this.state = {
            users :[],
            topUser:[],
            allBlockedUser:[],

            searchText:''
    
        }
    }

    async componentDidMount(){
        const data = await Axios.get('https://jsonplaceholder.typicode.com/users');
        console.log("users", data.data)
        this.setState({users:data.data})

        let allBlockedUser = JSON.parse(localStorage.getItem("blockedUsers") || "[]");
        this.setState({allBlockedUser})
        allBlockedUser = !allBlockedUser  ? [] : allBlockedUser;
        let users = [] ;
        allBlockedUser.forEach(user => {
            if( new Date().getTime() - user.timestamp < 10000){
                users.push(user)
            }
        });
        localStorage.setItem('blockedUsers',JSON.stringify(users))


    }

handleClick =(id,index)=>{
    const {getTopUsers} = this.props;
    const found = this.state.users.find(element => element.id == id);
    const sliced= this.state.users.slice(index, id);
    this.state.topUser.push(sliced[0]);
    
    
//    const newTopUser= {...this.state.topUser,...sliced[0]};
//    console.log("new user",this.state.topUser,)


    // this.state.users.splice(index,1); [if we don't want the same user in user navigation]
    
    this.setState({})
    getTopUsers(this.state.topUser);

   
}

handleBlockUser = (e, user)=>{
    console.log("handleBlockUser CLICKED", e.target.checked, user);
    let allBlockedUser = JSON.parse(localStorage.getItem("blockedUsers") || "[]");
    allBlockedUser = !allBlockedUser  ? [] : allBlockedUser
    user['timestamp']=new Date().getTime();
    if(e.target.checked){
        allBlockedUser.push(user)
        localStorage.setItem('blockedUsers',JSON.stringify(allBlockedUser));
        this.setState({allBlockedUser})
    }else if(!e.target.checked){
        let filteredBlockedUser = allBlockedUser.filter((u)=>u.id != user.id);
        localStorage.setItem('blockedUsers',JSON.stringify(filteredBlockedUser))
        this.setState({allBlockedUser:filteredBlockedUser})
    }
  
}
handleSearch = ()=>{
    let searchText = this.state.searchText;
    let searchedUsers = this.state.users.filter((user)=>{
        if(user.name.includes(searchText)){

            return user;
        }else if(user.email==searchText){
            return user;
        }
    });
    console.log("searched", searchedUsers)
    this.setState({users:searchedUsers})
}

    render() {
        let allBlockedUser = this.state.allBlockedUser;
        return (
            <div>
            <div className= "d-flex flex-row my-4 w-50 ">

            <input type="email" className="form-control" placeholder="Search..." id="search" onChange={(e)=>{this.setState({searchText:e.target.value})}}/>
            <button className="btn btn-primary" onClick= {this.handleSearch}>Search</button>
            </div>
            {this.state.users.length==0 && <div>No Users Found</div>}
            {this.state.users.length>0 &&<table className="table">
            <thead>
                <tr>
                <th scope="col"></th>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Blocked/Unblocked</th>
                </tr>
            </thead>
            <tbody>
                {
                    this.state.users.map((user,index)=>{
                        let isUserBlocked = allBlockedUser.filter((u)=>u.id==user.id);
                        return(
                            <tr key={index}>
                                <td><input type="checkbox" onClick={()=>this.handleClick(user.id,index)}/></td>
                                <th scope="row">{user.id}</th>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                                <td>
                                    <label className="switch">
                                        <input type="checkbox" checked={isUserBlocked.length>0 && isUserBlocked[0].id ? true : false} onChange = {(e)=>this.handleBlockUser(e, user)}/>
                                        <span className="slider round"></span>
                                    </label>
                                </td>

                            </tr>
                            )
                        })
                    }
                </tbody>
            </table>
            }
            </div>
        )
    }
}
