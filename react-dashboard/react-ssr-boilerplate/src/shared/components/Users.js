import React, { Component } from 'react'
import Axios from 'axios';
// import "./users.css"



export default class Users extends Component {
    constructor(){
        super();
        this.state = {
            users :[],
            topUser:[]
        }
    }

    async componentDidMount(){
        const data = await Axios.get('https://jsonplaceholder.typicode.com/users');
        console.log("users", data.data)
        this.setState({users:data.data})
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
    console.log("handleBlockUser CLICKED", e.target.value, user);
    let allBlockedUser = JSON.parse(localStorage.getItem("blockedUsers") || "[]");
    console.log("allBlockedUser", allBlockedUser);
    allBlockedUser = !allBlockedUser  ? [] : allBlockedUser
    console.log("allBlockedUser", allBlockedUser);
    allBlockedUser.push(user)
    localStorage.setItem('blockedUsers',JSON.stringify(allBlockedUser) )
}

    render() {
        return (
            <div>
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
                        return(
                            <tr key={index}>
                                <td><input type="checkbox" onClick={()=>this.handleClick(user.id,index)}/></td>
                                <th scope="row">{user.id}</th>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                                <td>
                                    <label className="switch">
                                        <input type="checkbox" onChange = {(e)=>this.handleBlockUser(e, user)}/>
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
