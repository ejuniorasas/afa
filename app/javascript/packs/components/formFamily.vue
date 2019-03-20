<template>

    <div class="modal-body">
        <!-- name: '', members: [{name:'', lastName:'', relation: '', doc:'', course:'', contacts:[{type: '', content: ''}]}]-->
        <div class="from-group">
            <div class="form-row col-md-8">
                <div class="col-md-6">
                    <label for="familyNameAdd">Family name:</label>
                </div>
                <div class="col-md-2">
                    <label for="statusAdd">Stituacio:</label>
                </div>
            </div>
            <div class="form-row col-md-8">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="familyNameAdd" v-model='family.name'>
                </div>
                <div class="col-md-2">
                    <select type="text" class="form-control" id="statusAdd" v-model='family.status'>
                        <option value="active">Activo</option>
                        <option value="pendent">Pendent</option>
                        <option value="expired">Caducado</option>
                        <option value="removed">Borrado</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="button" class="btn btn-labeled btn-success" @click='addMembers'>
                    <span class="btn-label"><i class="glyphicon glyphicon-plus"></i></span>Add members</button>
                </div>
            </div>
            <small id="familyNameHelp" class="form-text text-muted">last name of family...</small>
        </div>
        <div v-for='(member, index) in family.members' :key='index' class="col-md-6">

            <div class="from-group" >
                <div class="form-row">
                    <div class="col-md-6">
                        <label for="nameAdd">Name:</label>
                    </div>
                    <div class="col-md-6">
                        <label for="lastNameAdd">Last name:</label>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-6">
                        <input type="text" class="form-control" id="nameAdd" v-model='member.name'>
                    </div>
                    <div class="col-md-6">
                        <input type="text" class="form-control" id="lastNameAdd" v-model='member.last_name'>
                    </div>
                </div>
            </div>

            <div class="from-group" >
                <div class="form-row">
                    <div class="col-md-4">
                        <label for="relationAdd">Relation:</label>
                    </div>
                    <div class="col-md-4">
                        <label for="identityAdd">Identity:</label>
                    </div>
                    <div class="col-md-4">
                        <label for="courseAdd">Course:</label>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col-md-4">
                        <select type="text" class="form-control" id="relationAdd" v-model='member.relation'>
                            <option value="student">Alumne</option>
                            <option value="mother">Mare</option>
                            <option value="father">Pare</option>
                            <option value="tutor">Tutor</option>
                            <option value="responsable">Responsable</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input type="text" class="form-control" id="identityAdd" v-model='member.doc'>
                    </div>
                    <div class="col-md-4">
                        <input type="text" class="form-control" id="courseAdd" v-model='member.course'>
                    </div>
                </div>
            </div>

            <div class="from-group">
                <div class="form-row p-3 mb-2 bg-secondary text-white">
                    <p>Contact data :: <strong> {{member.name + ' ' + member.last_name}}</strong> :: </p>
                </div>
            </div>

            <div class="from-group" v-for="(contact, contactIndex) in member.contacts" :key="contactIndex">
                <div class="form-row">
                    <div class="col-md-3">
                        <select class="form-control" id="contactTypeAdd" v-model='contact.type'>
                            <option value="phone">Telefone</option>
                            <option value="email">Correo</option>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="contactContent" v-model='contact.content'>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-outline-danger btn-sm float-right" id="removeContact" @click="removeContact(member, contact)"> X </button>
                    </div>
                </div>
            </div>


            <div class="from-group breadcrumb" >
                    <div class="col-sm-6">
                        <button type="button" @click='removeItem(family.members, member)' class="btn btn-outline-danger btn-sm float-left">Remove member</button>
                    </div>
                    <div class="col-sm-6">
                        <button type="button" class="btn btn-outline-secondary btn-sm float-right" @click="addContacts(member)">Add Contact</button>
                    </div>
            </div>
        </div>
        <div class="from-group col-md-6" >
            <div class="form-row">
                <button type="button" class="btn btn-outline-success btn-sm btn-block" @click="saveContact">Save</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['familyRef'],
        data: function () {
            return { 
                family: { name: this.familyRef.name, status: this.familyRef.status, 
                    id: this.familyRef._id, isNew: this.familyRef.created_at === null,
                    members: this.familyRef.members ? this.familyRef.members.map(item => {
                        return {name: item.name, last_name: item.last_name, relation: item.relation,
                                doc: item.doc, course: item.course, contacts: item.contacts ?
                                   item.contacts.map(contact =>{
                                       return {type: contact.type, content: contact.content};
                                   }) :[] };}): [],
                    },
                };
        },
         methods: {
            addMembers() {
                if (this.family.members == undefined) {
                    this.family.members = [];
                }
                this.family.members.push({name:'', last_name:'', relation: '', doc:'', course:'', contacts:[]});
                console.log(this.family);
            },
            addContacts(member){
                if (member.contacts == undefined) {
                    member.contacts = [];
                }
                member.contacts.push({type: '', content: ''});
            },
            removeContact(member, contact)  {
                if (confirm("Are you sure? ")) {
                    member.contacts = member.contacts.filter(item => contact !== item);
                }
            },
            removeItem(collection, itemToRemove)  {
                if (confirm("Are you sure? ")) {
                    this.family.members = this.family.members.filter(item => itemToRemove !== item);
                    //collection = collection.filter(item => itemToRemove !== item);
                    //console.log(collection);
                }
                //member.contacts = member.contacts.filter(item => contact !== item);
            },
            saveContact() {
                (this.family.isNew ? this.$http.post('/families/', {family: this.family}) : 
                this.$http.put(`/families/${this.family.id.$oid}`, {family: this.family}) )
                .then(result => {Turbolinks.visit('/families/');})
                .catch(err => {console.log(err)});
            }
         }
    }
</script>