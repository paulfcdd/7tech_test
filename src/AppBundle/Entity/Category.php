<?php


namespace AppBundle\Entity;

use AppBundle\Entity\Traits\DateTrait;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Table(name="categories")
 * @ORM\Entity()
 * @ORM\HasLifecycleCallbacks()
 */
class Category
{
    use DateTrait;

    /**
     * @var int
     * @ORM\Column(type="integer")
     * @ORM\Id()
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\OneToOne(targetEntity="AppBundle\Entity\Category", mappedBy="parentId")
     */
    private $id;

    /**
     * @var string
     * @ORM\Column(unique=true)
     */
    private $name;

    /**
     * @ORM\ManyToOne(targetEntity="AppBundle\Entity\Category", inversedBy="id")
     * @ORM\JoinColumn(name="parent_id", referencedColumnName="id", nullable=true)
     */
    private $parent;

    /**
     * @ORM\ManyToMany(targetEntity="AppBundle\Entity\Article", inversedBy="categories")
     * @ORM\JoinTable(name="category_articles")
     */
    private $articles;

    public function __construct()
    {
        $this->articles = new ArrayCollection();
    }

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param string $name
     * @return Category
     */
    public function setName(string $name)
    {
        $this->name = $name;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getParent()
    {
        return $this->parent;
    }

    /**
     * @param mixed $parent
     * @return Category
     */
    public function setParent($parent)
    {
        $this->parent = $parent;
        return $this;
    }

    /**
     * @param Article $article
     * @return Category
     */
    public function addArticle(Article $article) {
        if (!$this->articles->contains($article)) {
            $this->articles->add($article);
            $article->addCategory($this);
        }

        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getArticles() {
        return $this->articles;
    }

    /**
     * @param Article $article
     * @return Category
     */
    public function removeArticle(Article $article) {
        if ($this->articles->contains($article)) {
            $this->articles->remove($article);
            $article->removeCategory($this);
        }

        return $this;
    }

}