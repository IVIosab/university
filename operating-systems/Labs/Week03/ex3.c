#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node* next;
};


void print_list(struct node*head)
{
    for(struct node* i = head; i != NULL; i = i->next)
    {
        printf("%d\n", i->data);
    }
}

void insert_node(struct node*head ,struct node *cur_node, struct node *new_node)
{
    if (cur_node == NULL)
    {
        head = new_node;
        return;
    }
    struct node *tmp = cur_node -> next;
    cur_node -> next = new_node;
    new_node -> next = tmp;
}

void delete_node(struct node*head, struct node *bad_node)
{
    for(struct node *i = head; i != NULL; i = i->next)
    {
        if(i -> next == bad_node)
        {
            i -> next = bad_node -> next;
            break;
        }
    }
}

int main()
{
    struct node *elem1, *elem2, *elem3, *elem4;

    elem1 = malloc(sizeof(struct node));
    elem2 = malloc(sizeof(struct node));
    elem3 = malloc(sizeof(struct node));
    elem4 = malloc(sizeof(struct node));

    elem1 -> data = 1;
    elem2 -> data = 2;
    elem3 -> data = 3;
    elem4 -> data = 4;

    insert_node(NULL, NULL, elem1);
    insert_node(elem1 ,elem1, elem2);
    insert_node(elem1 ,elem2, elem3);
    
	printf("Initial structure : \n");
    print_list(elem1);
	insert_node(elem1, elem2, elem4);
	printf("Insert node after node 2 : \n");
	print_list(elem1);
	
    delete_node(elem1,elem2);

	printf("Delete node2 : \n");
    print_list(elem1);
}
